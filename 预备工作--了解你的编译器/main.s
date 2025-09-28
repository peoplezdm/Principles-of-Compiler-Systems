.text
    .globl main
    .attribute	4, 16   
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0" 


mul:
    addi    sp, sp, -24 
    sd      ra, 16(sp)  
    sw      a0, 8(sp)   
    sw      a1, 4(sp)   
    remw    t0, a0, a1  
    addw    t1, a0, t0  
    mulw    a0, t1, a1  
    ld      ra, 16(sp)  
    addi    sp, sp, 24  
    ret                 


main:
    addi    sp, sp, -32 
    sd      ra, 24(sp)  
    sd      s1, 16(sp)  

    call    getint      
    sw      a0, 12(sp)  
    sw      a0, 8(sp)   


loop_start:
    lw      t0, 12(sp)  
    la      t1, m       
    lw      t2, 0(t1)   
    ble     t0, t2, loop_end


    lw      a0, 8(sp)   
    lw      t0, 12(sp)  
    addi    a1, t0, -1  
    call    mul         
    sw      a0, 8(sp)   


    li      t0, 100     
    bgt     a0, t0, break_loop 


    lw      t1, 12(sp)  
    mul     t2, t1, a0  
    li      t0, 500     
    ble     t2, t0, update_x 


break_loop:
    j       loop_end    


update_x:
    lw      t0, 12(sp)  
    addi    t0, t0, -1  
    sw      t0, 12(sp)  
    j       loop_start  


loop_end:
    lw      a0, 8(sp)   
    call    putint      


    fcvt.s.w ft0, a0    
    la       t0, pi     
    flw      ft1, 0(t0) 
    fadd.s   ft0, ft0, ft1
    la       t0, num    
    lw       t1, 0(t0)  
    fcvt.s.w ft2, t1    
    fdiv.s   fa0, ft0, ft2
    call     putfloat   

# 程序结束
    li       a0, 0      
    ld       s1, 16(sp) 
    ld       ra, 24(sp) 
    addi     sp, sp, 32 
    ret                 

# 数据段
    .data
m:      .word 1       
num:    .word 2, 4    
pi:     .float 3.14 