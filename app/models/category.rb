class Category < ActiveRecord::Base
	has_many :products, :dependent => :destroy

	def tag_names
		a=self.tags
		a.split(',').compact.reject { |x| x.blank? }
	end

	def tag_names=(new_tags)
		case new_tags
			when Array
				# NOTE: Surrounding commas are important!
				setter=",#{new_tags.join(',')},"
			when String
				set=new_tags.split(/,/)
				list=set.collect { |x| x.strip }
				# NOTE: Surrounding commas are important!
				setter=",#{list.join(',')},"
			else
				raise ArgumentError, "Don't know how to handle #{new_tags.class.name}"
		end

		self.tags=(setter)
	end
end
