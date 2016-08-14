Configus.build Rails.env do

  env :production do
    volume_inaccuracy 0.1
    distance 1000
    port_limit 3
  end

  env :development, :parent => :production do
  end

  env :test, :parent => :development do
  end
end
