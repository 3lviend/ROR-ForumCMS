ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'ror-forum.herokuapp.com',
  user_name: 'elvin.alvian.siagian@gmail.com',
  password: ENV['SENDGRID_API_KEY'],
  authentication: :plain
}
