def mailto email="user@example.com", string="contact me", classes
  mail_to = 'mailto:'
  at = '@'
  dot = '.'

  comp = email.split("@")

  # process string, if it is an email address
  if string.include?("@") then
    string.gsub!("@", at + "&zwnj;").gsub!(".", dot)
  end

  obfuscated_email = "<a class=\"#{classes}\" href='javascript:void(0)' rel='nofollow' onclick='str1=\"#{comp[0]}\";str2=\"#{comp[1]}\";this.href=\"#{mail_to}\" + str1 + \"@\" + str2'>"
  obfuscated_email += "<i class=\"fa fa-envelope-square\"></i>"
  obfuscated_email += string
  obfuscated_email += "</a>"

  return obfuscated_email
end

def format_date(date)
  date.strftime('%B %d, %Y')
end

def site_title_logo
  data.settings.site_title_logo_image
  rescue NameError
    nil
end

def title(title)
  @page_title = title
end

def format_title
  separator = ' | '
  if data.settings.reverse_title
    if current_article
      current_article.title + separator + data.settings.site_title
    elsif @page_title
      @page_title + separator + data.settings.site_title
    else
      data.settings.site_title
    end
  else
    if current_article
      data.settings.site_title + separator + current_article.title
    elsif @page_title
      data.settings.site_title + separator + @page_title
    else
      data.settings.site_title
    end
  end
end

def page_description
  if current_article && current_article.summary(100)
    description = current_article.summary
  elsif @page_title
    description = @page_title + ' page of ' + data.settings.site_title
  else
    description = data.settings.site_description
  end
  # remove html tags
  description.gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, '').gsub(/[\r\n]/, ' ')
end

def analytics_account
  google_analytics_account
  rescue NameError
    nil
end
