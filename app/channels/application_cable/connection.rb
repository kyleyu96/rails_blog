module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_user

    def connect
      self.current_user = set_current_user
    end

    def disconnect
    end

    private

    def set_current_user
      if current_user = User.find_by(id: cookies.encrypted[:user_id])
        current_user
      else
        reject_unauthorized_connection
      end
    end

  end
end
