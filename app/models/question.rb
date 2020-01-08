class Question < ApplicationRecord

  belongs_to :user
  # Adding `dependent: :destroy` tells Rails to delete
  # associated records before deleting the record itself.
  # In this case, when a question is deleted, its answers are 
  # deleted first to satisfy the foreign_key constraint 
  
  # You can also use `dependent: :nullify` which will casuse 
  # all associated answers to have their question_id column 
  # set to NULL before the question is destroyed. 
  
  # If you don't set either `dependent` option, you can end up
  # with answers in your db referencing question_ids hat 
  # no longer exist, likely leading to errors.
  # ALWAYS SET A DEPENDENT OPTION TO HELP MAINTAIN REFERENTIAL 
  # INTEGRITY 
  has_many(:answers, dependent: :destroy)

  # has_many :answers adds the following instance methods
  # to the question model:
  # answers
  # answers<<(object, ...)
  # answers.delete(object, ...)
  # answers.destroy(object, ...)
  # answers=(objects)
  # answers_singular_ids
  # answers_singular_ids=(ids)
  # answers.clear
  # answers.empty?
  # answers.size
  # answers.find(...)
  # answers.where(...)
  # answers.exists?(...)
  # answers.build(attributes = {}, ...)
  # answers.create(attributes = {})
  # answers.create!(attributes = {})
  # answers.reload


  #  Create validations by using the 'validates'
  # method. The arguments are (in order):
  # - A column names a symbol,
  # - Named arguments corresponding to validation rules

  # To read more on validations https://guides.rubyonrails.org/active_record_validations.html
  
  # Validations
  # rails has built in methods which allow us to create validations really easily
  validates :title, presence: true # will make sure a question has a title before saving it

  # validate uniquess of title
  validates :title, uniqueness: true
  
  # validating length of the body
  validates :body, length: {minimum: 5, maximum: 500}

  #
  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  validates :title, uniqueness: {scope: :body}

  # custom validation
  validate(:no_monkey)


  # scope(:recent, lambda { order(created_at: :desc).limit(10) })
  scope(:recent, -> { order(created_at: :desc).limit(10) })
  # Question Model
  # This got generated with the rails g model question title:string body:text
  # Question class inherits everything from ApplicationRecord

  # Rails will add attr_accessors for all columns of the table (i.e. id, title, body, created_at, updated_at)

  # Rails HOOK

  # before_validation is lifecycle callback method
  # that allows us to respond to events in an objects
  # lifecycle. (i.e. being validated, saved, updated etc.). These methods take a symbol named after a method and calls that method at the appropriate time
  before_validation :capitalize_title #before saving a record, execute the capitalize_title method
  before_validation :set_default_view_count

  
  private

  def capitalize_title
    self.title.capitalize!
  end

  # def self.recent
  #   order(created_at: :desc).limit(10)
  # end
  # ^ scopes like the above are such a commonly used
  # feature in Rails, there's a way to create them
  # quicker. It takes a name, and a lambda as a callback


  def no_monkey
    # &. is the safe navigator operator. It is used like the . operator to call methods on an object only if they exist
    if body&.downcase&.include?("monkey")
      # if a body of a question has the word "monkey" in it give us an error.

      # errors.add is used to add an error to the instance. It accepts 2 arguments
      # 1) the column/property you want the error to be on
      # 2) the error message
      self.errors.add(:body, "must not have monkeys")
    end
  end

    def set_default_view_count
    # If you are writing to an attribute accessor,
    # you must prefix with self, which you don't have
    # to do if you are just reading it.
    self.view_count ||= 0
    # self.view_count || self.view_count = 0
  end
end
