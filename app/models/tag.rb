class Tag < ApplicationRecord
    has_many :taggings, dependent: :destroy 
    has_many :questions, through: :taggings 

    validates :name, presence: true, uniqueness: { case_sensitive: false }

   
    before_validation :downcase_name
    
    private 

    def downcase_name 
        # self.name = self.name.downcase!
        # self.name && self.name.downcase!
        self.name&.downcase!
    end

    # THE FOLLOWING CODE SHOWS WHAT RUNNING A METHOD WITH BANG (!) DOES
    # def plus1 num
    #     num + 1
    # end

    # my_num = 3
    # my_num2 = plus1(my_num)!
    # puts my_num   # puts 4
    # puts my_num2  # puts 4

end
