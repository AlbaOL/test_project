class PdfService
    include HTTParty
    include PdfSectionPrinter
    require "prawn"
    
    def initialize(license)
      @license = license
    end
    
    def self.generate(license)
      new(license).generate
    end
  
    def generate
      filename = "License_#{DateTime.now}.pdf"
      Prawn::Document.generate(filename) do |pdf|
        page_1(pdf)
      end
    end
    
    private
    
    attr_reader :license
    
    SECTION_1_ATTRIBUTES = [
      {name: "rider_name",          label: "Rider name"},
      {name: "rider_license_id",    label: "License ID"},
      {name: "sex",                 label: "Sex"},
      {name: "expiration_date",     label: "Expiration Date"},
      {name: "rider_birth_date",    label: "Birth Date"}
    ]
    
    
    def page_1(pdf)
      attributes = SECTION_1_ATTRIBUTES.map do |attribute|
        attribute.merge(value: license[attribute[:name]].to_s)
      end
      print_section(pdf, "Rider's license", [{attributes: attributes}], false)
    end
  end