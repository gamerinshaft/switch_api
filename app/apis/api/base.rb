
module API
  class Base < Grape::API
    helpers do
      def save_object(object)
        if object.save
          object
        else
          errors = []
          object.errors.each do |key, value|
            errors << {
                message: "#{key} #{value}",
                code: ErrorCodes::FAIL_SAVE
            }
          end
          render json:{
                     errors: errors
                 }, status: 400
          false
        end
      end
    end

    mount V1::Base
  end
end
