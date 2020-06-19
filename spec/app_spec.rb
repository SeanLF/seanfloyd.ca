# frozen_string_literal: true

describe App do
  let(:app) { App }

  describe 'GET /' do
    it 'displays home page' do
      get '/'

      expect(last_response.body).to include('Sean Floyd')
      expect(last_response.body).to include('CV')
      expect(last_response.body).to include('GitHub profile')
      expect(last_response.body).to include('/email')
    end
  end

  describe 'GET /travel' do
    it 'displays travel page' do
      get '/travel'

      expect(last_response.body).to include('Travel Log')
      expect(last_response.body).to include('Photos')
    end
  end

  describe 'GET /travel/posts/*' do
    it 'displays a travel post' do
      get '/travel'

      travel_post_url = %r(/travel/posts/\d{4}-\d{2}-\d{2}).match(last_response.body)

      unless travel_post_url.nil?
        get travel_post_url[0]
        expect(last_response.body).to include('Back')
      end
    end
  end

  describe 'GET /:locale/cv' do
    it 'displays the CV in English' do
      get '/cv'

      expect(last_response.body).to include('Français')
      expect(last_response.body).to include('Sean Floyd')
      expect(last_response.body).to include('https://github.com/SeanLF')
      expect(last_response.body).to include('education')
      expect(last_response.body).to include('experience')
    end

    it 'displays the CV in French' do
      get '/fr/cv'

      expect(last_response.body).to include('English')
      expect(last_response.body).to include('Sean Floyd')
      expect(last_response.body).to include('https://github.com/SeanLF')
      expect(last_response.body).to include('formation')
      expect(last_response.body).to include('expérience')
    end
  end

  describe 'GET /emergency' do
    it 'displays the emergency page' do
      get '/emergency'

      expect(last_response.body).to include('In Case of Emergency')
      expect(last_response.body).to include('Contacts')
      expect(last_response.body).to include('Father')
      expect(last_response.body).to include('Mother')
    end
  end

  describe 'GET /email' do
    it 'triggers a mailto: event' do
      get '/email'

      expect(last_response.location).to include('mailto:')
      expect(last_response.location).to include('@')
      expect(last_response.location).to include('.com')
    end
  end

  describe 'GET /* not in routes' do
    it 'redirects to 404' do
      get '/doesnotexist'

      expect(last_response.status).to eq(302)

      get last_response.location

      expect(last_response.body).to include('404')
    end
  end

  describe 'Make CV from JSON file' do
    it 'displays the make CV page' do
      get '/cv/make'

      expect(last_response.body).to include('Make your own version of my CV')
    end

    it 'redirects if no file is submitted' do
      post '/cv/make'

      expect(last_response.status).to eq(302)
      expect(last_response.location).to include('/cv/make')
    end

    it 'creates the CV from the JSON file' do
      post '/cv/make', json_file: { tempfile: 'views/cv/fr.cv.json' }

      expect(last_response.body).to_not include('<nav>')
      expect(last_response.body).to include('Sean Floyd')
      expect(last_response.body).to include('https://github.com/SeanLF')
      expect(last_response.body).to include('formation')
      expect(last_response.body).to include('expérience')
    end
  end

  describe 'Get availability' do
    context 'french path' do
      it 'redirects to calendly' do
        get '/availability'

        expect(last_response.status).to eq(302)
        expect(last_response.location).to include('https://calendly.com/seanlf')
      end
    end

    context 'english path' do
      it 'redirects to calendly' do
        get '/disponibilite'

        expect(last_response.status).to eq(302)
        expect(last_response.location).to include('https://calendly.com/seanlf')
      end
    end
  end
end
