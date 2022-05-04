require_relative '../views/session_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @session_view = SessionView.new
  end

  def sign_in
    # ASK USER TO LOGIN
    # ASK THE EMPLOYEE FOR THE USERNAME
    username = @session_view.ask_for(:username)
    # ASK THE EMPLOYEE FOR THE PASSWORD
    password = @session_view.ask_for(:password)
    # RETRIEVE THE EMPLOYEE BY THE USERNAME
    # I NEED EMPLOYEE REPO
    employee = @employee_repository.find_by_username(username)
    # CHECK IF THE PASSWORD GIVEN MATCHES THE ONE IN THE DATABASE
    if employee && employee.password == password
      @session_view.logged_in_successfully
      return employee
    else
      # current_user was not found so it's nil
      @session_view.wrong_credentials
      sign_in # Recursive call
    end
  end
end
