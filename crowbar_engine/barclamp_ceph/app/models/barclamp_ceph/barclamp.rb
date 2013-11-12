# Copyright 2013, Dell
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class BarclampCeph::Barclamp < Barclamp

  def initialize(thelogger)
    @bc_name = "ceph"
    @logger = thelogger
  end

  def create_proposal
    @logger.debug("Ceph create_proposal: entering")
    base = super

    fsid = `uuidgen`
    fsid.chomp!
    
    base["attributes"]["ceph"]["config"]["fsid"] = fsid
    
    #For testing use only. Will be implemeted into the cookbook. 
    base["attributes"]["ceph"]["monitor-secret"] = `python /opt/dell/bin/monitor-secret.py`    
    
    @logger.debug("Ceph create_proposal: exiting")
    base
  end
  
    def apply_role_pre_chef_call(old_role, role, all_nodes)
      @logger.debug("Ceph apply_role_pre_chef_call: entering #{all_nodes.inspect}")
                                                            
      mon_nodes = role.override_attributes["ceph"]["elements"]["ceph-mon"]
      shortname = Array.new
      unless mon_nodes.nil? or mon_nodes.empty?
        mon_nodes.each do |n|
          node = NodeObject.find_node_by_name n
          shortname.push(n.split(".").first.concat(","))
          @logger.debug("Ceph assign node[:ceph-mon] for #{n}")
        end
      @logger.debug("Shortname array: #{shortname.inspect}")
      role.default_attributes["ceph"]["config"]["mon_initial_members"] = shortname
      role.save
      end
    end

end
