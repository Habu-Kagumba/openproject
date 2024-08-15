#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2024 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

class Company < ApplicationRecord
  belongs_to :owner, class_name: "User"

  # A company can have many child companies through the `shares` table
  has_many :shares_as_parent, class_name: "Share", foreign_key: "parent_id", inverse_of: :child, dependent: :destroy
  has_many :child_companies, through: :shares_as_parent, source: :child

  # A company can have many parent companies through the `shares` table
  has_many :shares_as_child, class_name: "Share", foreign_key: "child_id", inverse_of: :parent, dependent: :destroy
  has_many :parent_companies, through: :shares_as_child, source: :parent

  validates :name,
            :owner,
            presence: true
  validates :name, length: { maximum: 256 }
end
