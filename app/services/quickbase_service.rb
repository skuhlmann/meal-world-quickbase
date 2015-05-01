class QuickbaseService
  attr_reader :base_url, :auth_ticket

  def initialize
   @base_url = 'https://samkuhlmann.quickbase.com/db/'
   @auth_ticket = get_auth_ticket
  end

  def find_all
    response = HTTParty.get("#{base_url}bju4mdsdk?a=API_DoQuery&ticket=#{auth_ticket}&apptoken=#{ENV["APP_TOKEN"]}&clist=a")
    response.parsed_response["qdbapi"]["record"]
  end

  def find_by_record_id(id)
    response = HTTParty.get("#{base_url}bju4mdsdk?a=API_GetRecordInfo&rid=#{id}&ticket=#{auth_ticket}&apptoken=#{ENV["APP_TOKEN"]}")
    parse_record(response["qdbapi"]["field"])
  end

  def create_record(data)
    params = build_record_params(data)
    HTTParty.get("#{base_url}bju4mdsdk?a=API_AddRecord#{params}&ticket=#{auth_ticket}&apptoken=#{ENV["APP_TOKEN"]}")
  end

  def update_record(id, data)
    params = build_record_params(data)
    HTTParty.get("#{base_url}bju4mdsdk?a=API_EditRecord&rid=#{id}#{params}&ticket=#{auth_ticket}&apptoken=#{ENV["APP_TOKEN"]}")
  end

  def delete_record(id)
    HTTParty.get("#{base_url}bju4mdsdk?a=API_DeleteRecord&rid=#{id}&ticket=#{auth_ticket}&apptoken=#{ENV["APP_TOKEN"]}")
  end

  private

  def get_auth_ticket
    response = HTTParty.get("#{base_url}main?a=API_Authenticate&username=#{ENV["QB_USERNAME"]}&password=#{ENV["QB_PASSWORD"]}")
    response.parsed_response["qdbapi"]["ticket"]
  end

  def parse_record(data)
    response = Hash.new
    data.each do |field|
      response[field["name"]] = field["value"]
    end
    response["record_id_"] = response["Record ID#"]
    Hash[response.map { |k, v| [k.downcase, v] }]
  end

  def build_record_params(data)
    params = ""
    data.to_h.each do |k, v|
      params += "&_fnm_#{k}=#{v}"
    end
    params
  end
end
