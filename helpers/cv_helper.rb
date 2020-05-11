module CVHelper
  def icons
    {'GitHub' => 'github', 'StackOverflow' => 'stack-overflow', 'LinkedIn' => 'linkedin'}
  end

  def change_language_path
    href = request.fullpath
    if R18n.get.locale.code === 'en'
      '/fr' << href
    elsif R18n.get.locale.code === 'fr'
      href[3..-1]
    else
      ''
    end
  end
end