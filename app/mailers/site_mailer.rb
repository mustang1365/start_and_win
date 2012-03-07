class SiteMailer < ActionMailer::Base
  DEFAULT_FROM = 'm3.developers@gmail.com'
  FEEDBACK_EMAIL = 'm3.developers@gmail.com'
  DEFAULT_FROM_FEEDBACK_EMAIL = 'm3.developers@gmail.com'

  default from: DEFAULT_FROM
end
