class Post < ActiveRecord::Base
  
  
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags
  #accepts_nested_attributes_for :tags, reject_if: proc { |attributes| attributes.blank? }
  validates :name, :content, presence: true 
  
  def tags_ids
    self.tags.each {|t| t.id}
  end

  
  def tags_ids=(names)
    names.each do |tag|
      new_tag = Tag.find_or_create_by(id: tag)
      post_tag = PostTag.create(post_id: self.id, tag_id: new_tag.id)
      self.tags << new_tag
    end
  end
end
