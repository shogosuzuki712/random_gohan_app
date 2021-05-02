class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)
    @inquiry = inquiry
    mail to: ENV["GMAIL_USER_NAME"], subject: 'お問い合わせ通知'
  end
end
