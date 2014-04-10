class EV < Sinatra::Base
  def build_qr_url(qr)
    "http://#{File.join(request.host, 'qr', qr.slug)}"
  end

  get '/qr/:code/show' do
    if qr = QRCode[:slug => params[:code]]
      @qr = RQRCode::QRCode.new(
        build_qr_url(qr),
        :size => 4,
        :level => :h
      )
      erb :sign, :layout => false
    else
      not_found
    end
  end

  get '/qr/:code' do
    @qr = QRCode[:slug => params[:code]]
    if not @qr
      not_found
    end

    if @qr.linked?
      redirect "/status/#{qr.license.number}"
    else
      erb :"qr_codes/new"
    end
  end

  post '/qr/associate' do
    license = License.find_or_create_by_number params[:license]
    qr_code = QRCode[:slug => params[:slug]]

    license.add_qr_code qr_code

    redirect "/set/#{license.number}"
  end
end