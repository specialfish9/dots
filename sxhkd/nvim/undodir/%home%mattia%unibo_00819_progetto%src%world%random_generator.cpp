Vim�UnDo� �tS�<LW�"�9Q��y���]Ň�C"ű1;                    4       4   4   4    `�m�    _�                             ����                                                                                                                                                                                                                                                                                                                                                             `�j�     �                   5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `�j�     �                   �               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�j�     �                  #5�_�                       
    ����                                                                                                                                                                                                                                                                                                                                                             `�j�     �                  #include "header"5�_�                       
    ����                                                                                                                                                                                                                                                                                                                                                             `�j�     �                  #include ""5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�j�     �                   #include "random_generator.hpp""5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�j�     �                  �               5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                             `�j�     �                 using namespace world;5�_�      
           	          ����                                                                                                                                                                                                                                                                                                                                                             `�j�     �                  �               5�_�   	              
           ����                                                                                                                                                                                                                                                                                                                                                             `�k      �                using namespace World;5�_�   
                         ����                                                                                                                                                                                                                                                                                                                                                             `�k     �                  5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�k     �                 RandomGenerator5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `�k     �                5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `�k     �                5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�k     �               using namespace identifier;5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�k      �               using namespace ;5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�k"     �               using namespace Worl;5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�k2     �                 RandomGenerator::5�_�                       #    ����                                                                                                                                                                                                                                                                                                                                                             `�k8     �                 $RandomGenerator::RandomGenerator () �               5�_�                       $    ����                                                                                                                                                                                                                                                                                                                                                             `�k:     �                 %RandomGenerator::RandomGenerator () {�               5�_�                       %    ����                                                                                                                                                                                                                                                                                                                                                             `�k;     �                 &RandomGenerator::RandomGenerator () {}    �                  �               5�_�                       %    ����                                                                                                                                                                                                                                                                                                                                                             `�ka    �                 &RandomGenerator::RandomGenerator () {}5�_�                       $    ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �                 %RandomGenerator::RandomGenerator() {}5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �             �                �                5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �                 seed = time(time_t *__timer)5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �                 seed = time(*__timer)5�_�                          ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �                 seed = time(__timer)5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �                 seed = time()5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �   	   
   
    �         	      #include <ctime>�      	           seed = time(nullptr)5�_�                     	       ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �      
   
        srand(unsigned int __seed);5�_�      !               	       ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �      
   
        srand(int __seed);5�_�       "           !   	       ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �      
   
        srand(__seed);5�_�   !   #           "   	       ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �      
   
      
  srand();5�_�   "   $           #   	       ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �      
   
        srand(seed);5�_�   #   %           $   
        ����                                                                                                                                                                                                                                                                                                                                                             `�l2     �   
               �   
            5�_�   $   &           %      &    ����                                                                                                                                                                                                                                                                                                                                                             `�lD     �                 &uint RandomGenerator::next(uint bound)5�_�   %   '           &      %    ����                                                                                                                                                                                                                                                                                                                                                             `�lG     �                 &uint RandomGenerator::next(uint bound)�               5�_�   &   (           '      &    ����                                                                                                                                                                                                                                                                                                                                                             `�lI     �                 'uint RandomGenerator::next(uint bound){�               5�_�   '   )           (      '    ����                                                                                                                                                                                                                                                                                                                                                             `�lJ     �                 (uint RandomGenerator::next(uint bound){}5�_�   (   *           )           ����                                                                                                                                                                                                                                                                                                                                                             `�l�     �               'uint RandomGenerator::next(uint bound){5�_�   )   +           *           ����                                                                                                                                                                                                                                                                                                                                                             `�l�     �                5�_�   *   ,           +           ����                                                                                                                                                                                                                                                                                                                                                             `�l�     �               �               #include <cstdlib>�                  �               5�_�   +   -           ,      "    ����                                                                                                                                                                                                                                                                                                                                                             `�m     �                 #time_t RandomGenerator::get_seed() �               5�_�   ,   .           -      #    ����                                                                                                                                                                                                                                                                                                                                                             `�m     �                 $time_t RandomGenerator::get_seed() {�               5�_�   -   /           .      $    ����                                                                                                                                                                                                                                                                                                                                                             `�m     �                 %time_t RandomGenerator::get_seed() {}5�_�   .   0           /           ����                                                                                                                                                                                                                                                                                                                                                             `�m     �                5�_�   /   1           0          ����                                                                                                                                                                                                                                                                                                                                                             `�m0    �                 8RandomGenerator::uint RandomGenerator::next(uint bound){     return rand() % bound;   }           $time_t RandomGenerator::get_seed() {     return this->seed;   }5�_�   0   2           1          ����                                                                                                                                                                                                                                                                                                                                                             `�m�     �                #include <bits/types/time_t.h>5�_�   1   3           2          ����                                                                                                                                                                                                                                                                                                                                                             `�m�     �                #include <cstdlib>5�_�   2   4           3          ����                                                                                                                                                                                                                                                                                                                                                             `�m�    �                #include <ctime>5�_�   3               4           ����                                                                                                                                                                                                                                                                                                                                                             `�m�    �                 �              5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `�k�     �                 seed = time()5��