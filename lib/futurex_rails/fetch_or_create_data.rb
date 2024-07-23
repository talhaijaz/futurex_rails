module FutureXRails
  class FetchOrCreateData
    attr_reader :body, :client, :access_token, :api_url

    def initialize(body, client = FutureXRails.client)
      @api_url = 'https://futurex.nelc.gov.sa'
      @body = body.symbolize_keys
      @access_token = fetch_access_token
      @client = client
    end

    def fetch
      return invalid_params_response unless body[:access_token].present?

      OpenStruct.new(client.format_response(fetch_or_create_entity_data))
    end

    def get_api_call(url)
      client.get_api_data(url, access_token)
    end

    def post_api_call(url)
      client.post_api_data(url, body, access_token)
    end
    private

    def fetch_or_create_entity_data
      case body[:entity]
      when 'CreateCourse'
        create_course
      when 'OptionsForEntityFields'
        options_for_entity_fields
      when 'EnrollmentByProgress'
        enrollment_by_progress
      when 'LearnersByContentProvider'
        learners_by_content_provider(body[:providerId])
      when 'AccomplishmentCertificates'
        accomplishment_certificates
      end
    end

    def create_course
      return invalid_params_response unless body[:courseId].present? &&
        body[:name].present? && body[:description].present?

      url = api_url + "/create-course?_format=json"
      post_api_call(url)
    end

    def options_for_entity_fields
      error_response('invalid entity') unless body[:entity].present? && %w[course_level course_category skills tags language certificate_types].include?(body[:entity])
      url = api_url + "/field-options/vocabulary/#{body[:entity]}?_format=json"
      get_api_call(add_pagination_url(url, body[:items_per_page], body[:pageNumber]))
    end

    def enrollment_by_progress
      return invalid_params_response unless body[:courseId].present? &&
        body[:userId].present? &&
        body[:overallProgress].present? &&
        body[:overallProgress].to_i.between?(0, 100) &&
        body[:enrolledAt].present? && body[:isCompleted].present?

      url = api_url + "/enrollment-progress?_format=json"
      post_api_call(url)
    end

    def learners_by_content_provider(provider_id)
      return provider_id_not_found unless provider_id.present?

      url = api_url + "/api/v1/providers/#{provider_id}/learners?_format=json"
      get_api_call(url)
    end

    def accomplishment_certificates
      return invalid_params_response unless body[:courseId].present? && body[:userId].present?

      url = api_url + "/certificate?_format=json"
      post_api_call(url)
    end

    def provider_id_not_found
      error_response('ProviderId should be present')
    end

    def invalid_params_response
      error_response('Invalid params')
    end

    def error_response(message)
      OpenStruct.new({code: 400, body: message})
    end

    def add_pagination_url(url, items_per_page, page_number)
      if items_per_page.present?
        url = url + "?items_per_page=#{items_per_page}"
      end
      if page_number.present?
        url = url + "&pageNumber=#{page_number}" if items_per_page.present?
        url = url + "?pageNumber=#{page_number}"
      end
      url
    end
  end
end