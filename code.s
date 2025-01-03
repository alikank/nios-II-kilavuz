.section .text       # Kodun text (program) bölümünün başlangıcını belirtir
.global _start       # _start etiketini global yapar, böylece linker bu noktadan başlar

_start:             # Programın başlangıç noktası
    # LED'leri kontrol etmek için I/O adresi ayarlanıyor
    movia r2, 0x810 # r2 registerına LED'lerin bağlı olduğu I/O adresini yükler
                    # 0x810 örnek bir adrestir, gerçek donanıma göre değiştirilmeli
    
    movi r3, 0      # r3 registerı sayaç olarak kullanılacak
                    # Başlangıç değeri olarak 0 yükleniyor

counter_loop:       # Ana döngü etiketi
    stwio r3, 0(r2) # Store Word I/O komutu
                    # r3'teki sayaç değerini, r2'de tutulan I/O adresine yazar
                    # Böylece LED'ler sayaç değerine göre yanar

    # Gecikme (Delay) rutini başlangıcı
    movia r4, 1000000  # r4'e 1 milyon değerini yükler
                       # Bu değer gecikme süresini belirler
                       # Sistem clock hızına göre ayarlanmalıdır

delay:              # Gecikme döngüsü etiketi
    subi r4, r4, 1  # r4'ten 1 çıkarır (subtract immediate)
    bne r4, r0, delay # Branch if Not Equal komutu
                      # Eğer r4 sıfır değilse, delay etiketine geri döner
                      # Bu şekilde gecikme sağlanır

    # Sayaç değerini artırma
    addi r3, r3, 1  # r3'e 1 ekler (add immediate)
                    # Böylece sayaç bir artırılmış olur
    
    # Sayaç üst limit kontrolü
    movi r5, 256    # r5'e 256 değerini yükler
                    # 8-bit LED dizisi için üst limit
    
    bne r3, r5, counter_loop  # Eğer sayaç 256'ya ulaşmadıysa
                              # counter_loop'a geri dön
    
    movi r3, 0     # Eğer sayaç 256'ya ulaştıysa
                   # r3'ü (sayacı) sıfırla
    
    br counter_loop # Branch (koşulsuz dallanma) komutu
                   # Ana döngüye geri dön
