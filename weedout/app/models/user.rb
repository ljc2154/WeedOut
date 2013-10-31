class ProfessorValidator < ActiveModel::Validator
  require 'csv' # Chris, this is for our CSV reader
  def isRealProfessor(record)
    # # Louis insert code here

    # # determine if record.uni (example: cd2665 exists as known professor)
    # isProfessor = true
    # # then set full name like this
    # record.full_name = "Jae Lee"

    isProfessor = false
    CSV.foreach("config/professor_names.csv") do |row| # for each row in the csv
      if record.uni == row[0] # if the uni in row 1 = the record's name
        record.lastname = row[1]
        record.firstname = row[2]
        isProfessor = true  # set isProfessor to true
      end # end of if
    end # end of for
    return isProfessor
  end

  def validate(record)
    if record.signup_as_professor == true && !isRealProfessor(record)
      record.errors[:base] << "Not a real professor."      
    end
  end
end


class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :courses, foreign_key: "professor_id"
  before_validation :set_email
  after_validation :set_isprofessor
  validates_with ProfessorValidator

  def set_email
    if self.email == ""
      self.email = "#{self.uni}@columbia.edu"
    end
  end

  def set_isprofessor
    self.isprofessor = self.signup_as_professor
  end
end

class User::ParameterSanitizer < Devise::ParameterSanitizer
    private
    def account_update
        default_params.permit(:full_name, :signup_as_professor, :email, :password, :password_confirmation, :current_password)
    end

    def sign_up
        default_params.permit(:uni, :full_name, :signup_as_professor, :email, :password, :password_confirmation, :current_password)
    end
end
