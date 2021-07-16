module PdfSectionPrinter
    include TransformableAttributes
    
    # :print_section prints a section either on a new page or continues on a current page.
    # A section can have multiple groups. Each group can have a title and attributes.
    # Parameter :data should have the following format:
    #[
    #  {
    #    title: 'Group title or nil',
    #    attributes: [
    #      {:name, :label, :value, :type, :transformation_function}
    #    ]
    #  },
    #  ...
    #]
    # :height param overwrites a default height of a section which is 700.
    # :top_padding moves cursor down before printing the section.
    def print_section(pdf, title, data, new_page = true, height = 700, top_padding = 0)
      pdf.start_new_page if new_page
      pdf.move_down top_padding
      pdf.text title, style: :bold, size: 15
  
      pdf.line_width = 0.5
      pdf.join_style = :round
      pdf.stroke_color "dededf"
      pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width, height: height) do
  
        pdf.fill_color  "ffffff"
        pdf.fill_rectangle [0, pdf.cursor], pdf.bounds.right, pdf.bounds.top
        pdf.fill_color  "000000"
        pdf.transparent(0.5) { pdf.stroke_bounds }
        pdf.move_down 5
  
        pdf.float do
          pdf.bounding_box([5, pdf.cursor], width: 250, height: height) do
            data.each do |group|
              pdf.pad(5) { pdf.text group[:title], size: 12 , style: :bold } if group[:title]
              group[:attributes].each do |attribute|
                value = printable_attribute_value(attribute)
                height_ext = value.size < 50 ? 0 : 10 # calculate height extension for long texts
                pdf.pad(5) { pdf.text attribute[:label] , style: :normal}
                pdf.move_down height_ext
              end
            end
          end
        end
      
        pdf.bounding_box([180, pdf.cursor], width: 320, height: height) do
          pdf.stroke_color "dededf"
          data.each do |group|
            pdf.move_down 24 if group[:title]
            group[:attributes].each do |attribute|
              value = printable_attribute_value(attribute)
              height_ext = value.size < 50 ? 0 : 10 # calculate height extension for long texts
              pdf.fill_color  "eeeeee"
              pdf.fill_and_stroke_rounded_rectangle([5, pdf.cursor], 310, 18 + height_ext, 3)
              pdf.fill_color  "000000"
              pdf.text_box value, at: [10, pdf.cursor - 5], size: 9, overflow: :shrink_to_fit
              pdf.move_down 24 + height_ext
            end
          end
        end
          
      end
    end
    
    def printable_attribute_value(attribute)
      # Let's cut the value down to 130 characters to prevent
      # a layout broken by a long text...
      _value = transformed_attribute_value(attribute)[0..129]
      #...and remove new lines and tabs.
      ["\t", "\r", "\n"].each do |c|
        _value.delete!(c)
      end
      _value
    end
    
  end