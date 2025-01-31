#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2023 the OpenProject GmbH
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

RSpec.shared_examples 'a nextcloud synchronization trigger' do
  context 'when project_folder mode is automatic' do
    it 'schedules appropriate background job' do
      model_instance.project_folder_mode = 'automatic'
      subject
      expect(enqueued_jobs.count).to eq(1)
      expect(enqueued_jobs[0][:job]).to eq(Storages::ManageNextcloudIntegrationEventsJob)
    end
  end

  context 'when project_folder mode is manual' do
    it 'does not schedule a background job' do
      model_instance.project_folder_mode = 'manual'
      subject
      expect(enqueued_jobs.count).to eq(0)
    end
  end

  context 'when project_folder mode is inactive' do
    it 'does not schedule a background job' do
      model_instance.project_folder_mode = 'inactive'
      subject
      expect(enqueued_jobs.count).to eq(0)
    end
  end
end
