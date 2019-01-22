`ifndef __PW_CHECK_CONFIG_SV__
`define __PW_CHECK_CONFIG_SV__

class check_config extends uvm_object;
   static uvm_component uvm_nodes[string];
   static bit is_inited = 0;

   `uvm_object_utils(check_config)
   function new(string name = "check_config");
      super.new(name);
   endfunction

   static function void init_uvm_nodes(uvm_component c);
      uvm_component children[$];
      string cname;
      uvm_component cn;
      uvm_sequencer_base sqr;
  
      is_inited = 1; 
      if(c != uvm_root::get()) begin
         cname = c.get_full_name();
         uvm_nodes[cname] = c;
         if($cast(sqr, c)) begin
            string tmp;
            $sformat(tmp, "%s.pre_reset_phase", cname);
            uvm_nodes[tmp] = c;
            $sformat(tmp, "%s.reset_phase", cname);
            uvm_nodes[tmp] = c;
            $sformat(tmp, "%s.post_reset_phase", cname);
            uvm_nodes[tmp] = c;
            $sformat(tmp, "%s.pre_configure_phase", cname);
            uvm_nodes[tmp] = c;
            $sformat(tmp, "%s.configure_phase", cname);
            uvm_nodes[tmp] = c;
            $sformat(tmp, "%s.post_configure_phase", cname);
            uvm_nodes[tmp] = c;
            $sformat(tmp, "%s.pre_main_phase", cname);
            uvm_nodes[tmp] = c;
            $sformat(tmp, "%s.main_phase", cname);
            uvm_nodes[tmp] = c;
            $sformat(tmp, "%s.post_main_phase", cname);
            uvm_nodes[tmp] = c;
            $sformat(tmp, "%s.pre_shutdown_phase", cname);
            uvm_nodes[tmp] = c;
            $sformat(tmp, "%s.shutdown_phase", cname);
            uvm_nodes[tmp] = c;
            $sformat(tmp, "%s.post_shutdown_phase", cname);
            uvm_nodes[tmp] = c;
         end
      end
      c.get_children(children);
      while(children.size() > 0) begin
         cn = children.pop_front();
         init_uvm_nodes(cn); 
      end
   endfunction

   static function bit path_reachable(string scope);
      bit err;
      int match_num;
   
      match_num = 0;
      foreach(uvm_nodes[i]) begin
         err = uvm_re_match(scope, i);
         if(err) begin
            //$display("not_match: name is %s, scope is %s", i, scope);
         end
         else begin
            //$display("match: name is %s, scope is %s", i, scope);
            match_num++;
         end
      end
   
      return (match_num > 0);
   endfunction

   static function void check_all();
      uvm_component c;
      uvm_resource_pool rp; 
      uvm_resource_types::rsrc_q_t rq;
      uvm_resource_types::rsrc_q_t q; 
      uvm_resource_base r;
      uvm_resource_types::access_t a;
      uvm_line_printer printer;
   
   
      c = uvm_root::get();
      if(!is_inited)
         init_uvm_nodes(c);
   
      rp = uvm_resource_pool::get();
      q = new;
      printer=new();
      
      foreach(rp.rtab[name]) begin
         rq = rp.rtab[name];
         for(int i = 0; i < rq.size(); ++i) begin
            r = rq.get(i);
            //$display("r.scope = %s", r.get_scope());
            if(!path_reachable(r.get_scope)) begin
               `uvm_error("check_config", "the following config_db::set's path is not reachable in your verification environment, please check")
               r.print(printer);
               r.print_accessors();
            end
         end
      end
   endfunction


endclass

function void check_all_config();
   check_config::check_all();
endfunction

`endif

