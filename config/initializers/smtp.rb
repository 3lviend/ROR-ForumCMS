ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'ror-forum.herokuapp.com',
  user_name: 'elvin.alvian.siagian@gmail.com',
  password: ENV['SMTP_PASSWORD'],
  authentication: :plain,
  enable_starttls_auto: true,
  openssl_verify_mode: "none"
}
