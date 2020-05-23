#include "RubyGame.h"

VALUE rb_mRubyGame;

void
Init_RubyGame(void)
{
  rb_mRubyGame = rb_define_module("RubyGame");
}
