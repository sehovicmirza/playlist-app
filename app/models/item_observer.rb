class ItemObserver < ActiveRecord::Observer
    def before_save(resource)
        video = Yt::Video.new url: resource.ytlink
        resource.title = video.title
        resource.thumbnail_url = video.thumbnail_url
    rescue Yt::Errors::NoItems
        resource.title = ''; resource.thumbnail_url = ''
    end
end