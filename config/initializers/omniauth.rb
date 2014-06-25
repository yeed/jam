OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '822495544429570', 'd02326f2771ecd69a207e7256f1a5504'
end