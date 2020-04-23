class Movie < Sequel::Model
  def validate
    super
    errors.add(:name, 'Name cannot be empty') if !name || name.empty?
    errors.add(:description, 'Description cannot be empty') if !description || description.empty?
    errors.add(:image_url, 'Image Url cannot be empty') if !image_url || image_url.empty?
  end
end
