# Preview all emails at http://localhost:3000/rails/mailers/inquiry
class InquiryPreview < ActionMailer::Preview
  def inquiry
    @inquiry = Inquiry.new(name: "何食べる太郎", message: "問い合わせテストメッセージ")

    InquiryMailer.send_mail(@inquiry)
  end
end
