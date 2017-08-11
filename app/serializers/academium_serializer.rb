class AcademiumSerializer < ActiveModel::Serializer
  attributes :name, :local, :code, :superior_department, :level, :remark
end
