module Jms
  module PdfConverter
    module Processors
      module ImageMagickProcessor
      
        protected
        
        def process_pdf(format)
          path      = filename_for_pdf
          pdf_path  = path.sub(/pdf$/, format)
          
          if !self.is_pdf?
            raise Jms::PdfConverter::PDFError, "File is not a pdf" 
          end
          
          # If you are having trouble with the legibility of the png's or jpg's returned try these options:
          # convert -verbose -colorspace RGB -resize 800 -interlace none -density 300 -quality 80 input.pdf output.jpg
          cmd = "convert #{pdf_options[:processor_options].shift.to_s} #{path} #{pdf_path}"
          `#{cmd}`
          if $? != 0
            raise Jms::PdfConverter::ConversionError, "#{cmd} falied" 
          end
        end
        
      end
    end
  end
end