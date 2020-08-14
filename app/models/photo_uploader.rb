class PhotoUploader < CarrierWave::Uploader::Base

    storage :file

    include CarrierWave::MiniMagick
  
    version :thumb do
      process resize_to_fill: [289.98, 193.27]
    end
    
    def store_dir
        'public/img'
      end
    
    def content_type_whitelist
        [/image\//]
    end

    def extension_whitelist
      %w[jpg jpeg png]
    end 

end