class PhotoUploader < CarrierWave::Uploader::Base

    storage :file

    include CarrierWave::MiniMagick

    process resize_to_fit: [289.98, 193.27]

    version :thumb do
      process resize_to_fill: [289.98, 193.27]
    end
    
    def store_dir
        'public/uploads'
    end

    def load_photos
      Dir.glob("public/uploads/*.{jpg,JPG}")
    end

    def content_type_whitelist
        [/image\//]
    end

    def extension_whitelist
      %w[jpg jpeg]
    end 

end