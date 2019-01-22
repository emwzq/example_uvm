`ifndef IP_TRANSACTION__SV
`define IP_TRANSACTION__SV

class ip_transaction extends uvm_sequence_item;
  
    //ip header
    rand    bit [3:0]  version;//protocol version
    rand    bit [3:0]  ihl;// ip header length
    rand    bit [7:0]  diff_service; // service type, tos(type of service)
    rand    bit [15:0] total_len;// ip telecom length, include payload, byte
    rand    bit [15:0] iden;//identification
    rand    bit [2:0]  flags;//flags
    rand    bit [12:0] frag_offset;//fragment offset
    rand    bit [7:0]  ttl;// time to live
    rand    bit [7:0]  protocol;//protocol of data in payload
    rand    bit [15:0] header_cks;//header checksum
    rand    bit [31:0] src_ip; //source ip address
    rand    bit [31:0] dest_ip;//destination ip address
    rand    bit [31:0] other_opt[];//other options and padding
    rand    bit [7:0]  payload[];//data

    constraint ip_default_con {
        version          == 4  ; 
        ihl              == 5  ; 
        diff_service     == 0  ; 
        total_len        >= 20 ; 
        iden             == 0  ; 
        flags            == 0  ; 
        frag_offset      == 0  ; 
        ttl              == 64 ; 
        protocol         == 17 ; 
        header_cks       == 0  ; 
        other_opt.size() == 0  ; 
        payload.size()   >= 26 ; 
        payload.size()   <= 1480 ; 
    }

    `uvm_object_utils_begin (ip_transaction)
        `uvm_field_int (version         , UVM_ALL_ON)
        `uvm_field_int (ihl             , UVM_ALL_ON)
        `uvm_field_int (diff_service    , UVM_ALL_ON)
        `uvm_field_int (total_len       , UVM_ALL_ON)
        `uvm_field_int (iden            , UVM_ALL_ON)
        `uvm_field_int (flags           , UVM_ALL_ON)
        `uvm_field_int (frag_offset     , UVM_ALL_ON)
        `uvm_field_int (ttl             , UVM_ALL_ON)
        `uvm_field_int (protocol        , UVM_ALL_ON)
        `uvm_field_int (header_cks      , UVM_ALL_ON)
        `uvm_field_int (src_ip          , UVM_ALL_ON)
        `uvm_field_int (dest_ip         , UVM_ALL_ON)
        `uvm_field_array_int (other_opt , UVM_ALL_ON)
        `uvm_field_array_int (payload   , UVM_ALL_ON)
    `uvm_object_utils_end

    extern function new  (string name = "ip_transaction");
    extern function void calc_cks();
    extern function bit cks_valid();
    extern function void post_randomize();
     
endclass

function ip_transaction::new(string name="ip_transaction");
    super.new(name);
endfunction // new

function void ip_transaction::calc_cks();
    int opt_size;
    bit[31:0] tmp_cks;
    bit[31:0] tmp2_cks;
    
    tmp_cks  = {version, ihl, diff_service};
    tmp_cks += total_len + iden;
    tmp_cks += {flags, frag_offset};
    tmp_cks += {ttl, protocol};
    tmp_cks += 16'h0;//treat tmp_cks itself as 16'h0
    tmp_cks += src_ip[31:16] + src_ip[15:0];
    tmp_cks += dest_ip[31:16] + dest_ip[15:0];
    opt_size = other_opt.size();
    for (int i = 0; i < opt_size; i++)begin
        tmp_cks += other_opt[i][31:16] + other_opt[i][15:0];
    end
    tmp2_cks = tmp_cks[31:16] + tmp_cks[15:0];
    header_cks = ~(tmp2_cks[31:16] + tmp2_cks[15:0]); 

endfunction

function bit ip_transaction::cks_valid();
    int opt_size;
    bit[15:0] exp_cks;
    bit[31:0] tmp_cks;
    bit[31:0] tmp2_cks;
    
    tmp_cks  = {version, ihl, diff_service};
    tmp_cks += total_len + iden;
    tmp_cks += {flags, frag_offset};
    tmp_cks += {ttl, protocol};
    tmp_cks += header_cks; 
    tmp_cks += src_ip[31:16] + src_ip[15:0];
    tmp_cks += dest_ip[31:16] + dest_ip[15:0];
    opt_size = other_opt.size();
    for (int i = 0; i < opt_size; i++)begin
        tmp_cks += other_opt[i][31:16] + other_opt[i][15:0];
    end
    tmp2_cks = tmp_cks[31:16] + tmp_cks[15:0];
    exp_cks = tmp2_cks[31:16] + tmp2_cks[15:0]; 
    if(exp_cks != 16'hFFFF) begin
        cks_valid = 0;
    end
    else begin 
        cks_valid = 1;
    end

endfunction

function void ip_transaction::post_randomize();
    total_len = 20 + other_opt.size() + payload.size();
    calc_cks();
endfunction
`endif



