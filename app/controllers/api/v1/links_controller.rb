module Api
  module V1
    class LinksController < Api::V1::ApiController
      before_action :set_link, only: [:short_url, :stats]
      before_action :set_domain, only: [:short_url]

      def short_url
        link_count = @link.increment(:clicks, 1)
        link_count.save
        if @link.present?
          render json: { short_url: "#{@domain}/#{@link.name}", full_url: @link.url }, status: :ok
        else
          render json: { message: 'No such link' }, status: :unprocessable_entity
        end
      end

      def urls
        @link = Link.new(link_params)

        if @link.save
          render json: { full_url: @link.url }, status: :created
        else
          render json: { message: 'Link was not created' }, status: :unprocessable_entity
        end
      end

      def stats
        render json: { link_counter: @link.clicks }, status: :ok
      end

      private

      def set_link
        @link = Link.find_by(name: params[:name])
      end

      def link_params
        params.permit(:name, :url)
      end

      def set_domain
        @domain = "https://#{request.host}:#{request.port}"
        @domain
      end
    end
  end
end
