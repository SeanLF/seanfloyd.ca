# frozen_string_literal: true

## Provides helpers for the CV page

module CVHelper
  def icons
    { 'GitHub' => 'github', 'StackOverflow' => 'stack-overflow', 'LinkedIn' => 'linkedin' }
  end

  def cv_paths
    paths = {
      'en' => '/en/cv',
      'fr' => '/fr/cv'
    }
    unless request.env['QUERY_STRING'].nil?
      R18n.get.available_locales.map(&:code).each do |locale|
        paths[locale] += "?#{request.env['QUERY_STRING']}"
      end
    end
    paths
  end

  def change_cv_language_path
    if R18n.get.locale.code.include? 'en'
      cv_paths['fr']
    else
      cv_paths['en']
    end
  end
end
