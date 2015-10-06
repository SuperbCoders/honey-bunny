xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  xml.url do
    xml.loc root_url
    xml.changefreq("weekly")
    xml.priority("1.00")
  end
  xml.url do
    xml.loc blog_root_url
    xml.changefreq("weekly")
    xml.priority("1.00")
  end
  @posts.each do |post|
    xml.url do
      xml.loc blog_post_url(post)
      xml.changefreq("weekly")
      xml.lastmod post.updated_at.strftime("%F")
      xml.priority("0.80")
    end
  end
  @pages.each do |page|
    xml.url do
      xml.loc page_url(page.slug)
      xml.changefreq("weekly")
      xml.lastmod page.updated_at.strftime("%F")
      xml.priority("0.80")
    end
  end

  xml.url do
    xml.loc faqs_url
    xml.changefreq("weekly")
    xml.priority("1.00")
  end

  xml.url do
    xml.loc wholesale_url
    xml.changefreq("weekly")
    xml.priority("1.00")
  end

  xml.url do
    xml.loc questions_url
    xml.changefreq("weekly")
    xml.priority("1.00")
  end

  xml.url do
    xml.loc items_url
    xml.changefreq("weekly")
    xml.priority("1.00")
  end
  @items.each do |item|
    xml.url do
      xml.loc item_url(item)
      xml.lastmod item.updated_at.strftime("%F")
      xml.changefreq("weekly")
      xml.priority("0.80")
      xml.image :image do
        xml.image :loc, root_url+item.main_image.full.url
      end
    end
  end
end
