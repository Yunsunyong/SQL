龕봅   4 `  com/week4/TestWork2  java/lang/Object <init> ()V Code
  	   LineNumberTable LocalVariableTable this Lcom/week4/TestWork2; main ([Ljava/lang/String;)V  J a v a  P r o g r a m 	    java/lang/System   out Ljava/io/PrintStream;
    java/io/PrintStream   println (Ljava/lang/String;)V  java/lang/StringBuilder ! 湲?먭갗??: 
  #  
 % ' & java/lang/String ( ) length ()I
  + , - append (I)Ljava/lang/StringBuilder;
  / 0 1 toString ()Ljava/lang/String; 3 java/util/StringTokenizer
 2 #
 2 6 7 ) countTokens
 2 9 : 1 	nextToken
 % < = > charAt (I)C
 2 @ A B 
hasMoreTokens ()Z
  D E F print (C)V
  H  
 % J  K ([C)V
 % M N 1 toUpperCase args [Ljava/lang/String; str Ljava/lang/String; st Ljava/util/StringTokenizer; chArr [C index I i afterStr 
StackMapTable P V 
SourceFile TestWork2.java !               /     *? ?    
                 
   	      r     ?L? +? ? ? Y ? "+? $? *? .? ? 2Y+? 4M? ? Y ? ",? 5? *? .? ,? 5?N6? -?,? 8? ;U,? ???6? ? -4? C?-쐴鐫 ? G? %Y-? I:? ? L? ?    
   R    	   
 
 #  ,  E  K  L  O  R  X  `  a  h  n  x  ?   ? # ? ' ? )    H    ? O P    ? Q R  , r S T  L R U V  O O W X  k  Y X  ?  Z R  [     R  \ % 2 ]  ?   ^    _