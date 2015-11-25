module API
  class Base < Grape::API
    mount V1::Base
    # mount V2::Base
    add_swagger_documentation

  end
end