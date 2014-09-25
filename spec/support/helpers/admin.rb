def authenticate_admin(admin)
  admin.role = 'admin'
  admin.save
  sign_in_as(admin)
end
