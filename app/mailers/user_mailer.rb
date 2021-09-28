class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "【ShiftApp】仮登録完了メール"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "【ShiftApp】パスワード再設定"
  end
end
