require 'rubygems'
require 'oauth'
require 'json'

baseurl = "http://xxxcnn0330.locaweb.com.br"
path    = "/tweeps"
address = URI("#{baseurl}#{path}")
request = Net::HTTP::Get.new address.request_uri


def cria_timelime_seletiva(tweets)
  # Ordena os tweets por seguidores
  ordenar = tweets['statuses'].sort_by { |k| k["user"]["followers_count"] }.reverse
  ordenar.each do |tweet|
    if tweet["entities"]["user_mentions"][0] != nil && tweet["entities"]["user_mentions"][0] != 0
      id = tweet["entities"]["user_mentions"][0]["id"]
      # Se o ID eh igual a 42, cria a Timeline
      if id == 42
        puts
        puts "#################### Tweet Encontrado #####################################################################"
        puts "#"
        puts "# **************************************************************************************************"
        puts "# * @#{tweet["user"]["screen_name"]} - Link: http://www.twitter.com/#{tweet["user"]["screen_name"]}         "
        puts "# **************************************************************************************************"
        puts "# Numero de seguidores: #{tweet["user"]["followers_count"]} "
        puts "# Numero de Retweets: #{tweet["retweet_count"]} "
        puts "# Numero de Favoritado: #{tweet["user"]["favourites_count"]} "
        puts "# ================================================================================"
        puts "# Conteudo"
        puts "#"
        puts "# #{tweet["text"]}"
        puts "# ================================================================================"
        puts "# Criado em #{tweet["created_at"]}"
        puts "#"
        puts "# Link para o Tweet - https://twitter.com/#{tweet["user"]["screen_name"]}/status/#{tweet["id_str"]}"
        puts "#"
        puts "################################# FIM #####################################################################"
      end
    end
  end
end

# Configuracao HTTP
http             = Net::HTTP.new address.host, address.port

# Requisicao HTTP com header com Usuario
request.initialize_http_header({"Username" => "aderleifilho@gmail.com"})
http.start
response = http.request request

# Inicializacao dos tweets
tweets = nil
# Se OK cria a timeline
if response.code == '200' then
  tweets = JSON.parse(response.body)
  cria_timelime_seletiva(tweets)
end

