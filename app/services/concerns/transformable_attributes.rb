module TransformableAttributes
    private
  
    def transformed_attribute_value(attribute)
      call_custom_transformation_function(
        attribute[:transformation_function], # attribute transformation function
        call_type_based_transformation_function(
          attribute[:type],                  # attribute type
          attribute[:value].to_s             # attribute value
        )
      )
    end
    
    def call_type_based_transformation_function(type, value)
      # All type based transformation functions are named as <type>_transformation.
      # For example, string_transformation. NOTE: string is a default type if a 
      # given type is nil.
      begin
        send("#{type || :string}_transformation", value)
      rescue
        value
      end
    end
    
    def call_custom_transformation_function(function, value)
      begin
        function ? send(function, value) : value
      rescue Exception => e
        value # return orginal value if a transformation function fails
      end
    end
  end