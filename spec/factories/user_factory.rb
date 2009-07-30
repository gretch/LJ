Factory.define :user do |user|
  user.login 'johndoe'
  user.email { |u| "#{u.login.try(:gsub, '@', '_')}@example.com".downcase }
  user.password              'monkey'
  user.password_confirmation 'monkey'
end

Factory.define :quentin, :parent => :user do |user|
  user.login 'quentin'

  user.created_at 5.days.ago
  user.remember_token_expires_at 1.day.from_now
  user.remember_token '77de68daecd823babbb58edb1c8e14d7106e83bb'
  user.activated_at 5.days.ago
  user.state 'active'
end

Factory.define :aaron, :parent => :user do |user|
  user.login 'aaron'

  user.created_at 1.day.ago
  user.activation_code '1b6453892473a467d07372d45eb05abc2031647a'
  user.state 'pending'
end

Factory.define :old_password_holder, :parent => :user do |user|
  user.login 'old_password_holder'

  user.created_at 1.days.ago
  user.activated_at 5.days.ago
  user.state 'active'
end
