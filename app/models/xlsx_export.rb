class XlsxExport < ActiveRecord::Base
  belongs_to :author, class_name: 'User'

  acts_as_xlsx if MY_FEATURE[:gem_axlsx]

  validates :name, presence: true
  validates_inclusion_of :some_flag, in: [true, false]

  before_create :set_author

  def set_author
    self.author_id = User.current.id
  end
end
