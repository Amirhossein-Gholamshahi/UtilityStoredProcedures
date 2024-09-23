using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace ConsoleApp
{
    public class TextReplacer
    {
        // کالکشن خود را در این قسمت تعریف کنید

        public string tagChar;
        private Dictionary<string, string> tagReplacements;
        public TextReplacer(string tagChar)
        {
            this.tagChar = tagChar;
            tagReplacements = new Dictionary<string, string>();
        }

        public void AddTag(string tagName, string tagValue)
        {
            tagReplacements.Add(tagName, tagValue);
        }
 
        public string ReplaceTags(string text)
        {
            foreach (string tag in tagReplacements.Keys)
            {
                text = text.Replace( this.tagChar + tag, tagReplacements[tag]);
            }
            return text;
        }
    }
}
