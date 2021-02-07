!to "out/xfer.bin", plain

READST = $FFB7
CHKOUT = $FFC9
CHROUT = $FFD2
CLRCHN = $FFCC

USB_STATUS = $de09
USB_DATA   = $de0a

cmd_buffer = $c400      ; 12 bytes

        * = $c000

        jmp ef3usb_check_cmd

!zone {
        ; write to file 1
        ldx #1
        jsr CHKOUT

        ; loader code
        ; send "load" to USB
        jsr ef3usb_send_load

        ; request 64k data
        lda #$ff
        jsr usb_tx
        jsr usb_tx

        ; get number of bytes actually there
        jsr usb_rx              ; low byte of transfer size
        tax
        jsr usb_rx              ; high byte of transfer size
        tay
.loop
        dex
        cpx #$ff
        bne .transfer
        dey
        cpy #$ff
        beq .end
.transfer
        jsr READST
        bne .write_error

        jsr usb_rx      ; get byte from USB
        jsr CHROUT      ; write byte to file
        jmp .loop
.end
        lda #0
        jsr usb_tx      ; send 0, 0 => usb_fclose
        jsr usb_tx
.write_error
        sta $02
        jmp CLRCHN      ; restore output to screen
do_rts
        rts
}

; =============================================================================
;
; Send the string "load\0" to USB.
;
; =============================================================================
!zone {
ef3usb_send_load
        ldy #.load_str_end - .load_str - 1
.byte_loop
        lda .load_str, y
        jsr usb_tx
        dey
        bmi do_rts
        bpl .byte_loop
.load_str
        !pet 0, "daol" ; that's "load\0" backwards
.load_str_end
}

; =============================================================================
;
; Check if the command to start a PRG arrived from USB. The format is:
;
; Len:      012345678901
; Command: "efstart:prg#"  <= # = 0-termination
;
; Return 0 if there is no command complete. Return the 0-terminated file
; type (e.g. "crt") if it is complete.
;
; =============================================================================
!zone {
ef3usb_check_cmd
        ; move the buffer to the left
        ldx #0
.move_buf
        lda cmd_buffer + 1, x
        sta cmd_buffer, x
        inx
        cpx #11
        bne .move_buf

        ; append new byte
        jsr usb_rx
        sta cmd_buffer + 11

        ; check if the buffer contains out command
        ldx #.efstart_str_end - .efstart_str - 1
.check
        lda cmd_buffer, x
        cmp .efstart_str, x
        bne ef3usb_check_cmd
        dex
        bpl .check
.end
        rts

.efstart_str
        !pet "efstart:prg", 0
.efstart_str_end
}

; =============================================================================
;
; =============================================================================
!zone {
usb_tx
        bit USB_STATUS
        bvc usb_tx
        sta USB_DATA
        rts
}

; =============================================================================
;
; =============================================================================
!zone {
usb_rx
        bit USB_STATUS
        bpl usb_rx
        lda USB_DATA
        rts
}
