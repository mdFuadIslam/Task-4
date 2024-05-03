class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    # Add custom validation for name
    if resource.name =~ /[^a-z\s]/i
      resource.errors.add(:name, "cannot contain anything other than letters (A-z)")
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
      return
    end

    # Add custom validation for email
    if resource.email =~ /^\d+|[^a-zA-Z0-9@.]|(@.+)\z/
      resource.errors.add(:Email, "is invalid.")
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
      return
    end
    # if resource.email =~ /^\d+@|[^\w@]/
    #   resource.errors.add(:Email, "cannot have special characters such as !,#,$,% etc")
    #   clean_up_passwords resource
    #   set_minimum_password_length
    #   respond_with resource
    #   return
    # end

    if resource.save
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end
