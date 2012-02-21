module DataConversionHelper
  #return date in standard format. One format all over the site
  def standard_date(date)
    begin
      date.strftime('%d.%m.%Y')
    rescue
      nil
    end
  end
end
