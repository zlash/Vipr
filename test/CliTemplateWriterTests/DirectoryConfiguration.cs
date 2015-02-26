using System.Collections.Generic;
using TemplateWriter;

namespace CliTemplateWriterTests
{
    public class DirectoryConfiguration : ITemplateConfiguration
    {
        public string PrimaryNamespaceName { get; set; }
        public IReadOnlyDictionary<string, string> Parameters { get; set; }
        public HashSet<string> Languages { get; set; }

        public string NamespacePrefix { get; set; }

        public DirectoryConfiguration()
        {
            PrimaryNamespaceName = "Microsoft.DirectoryServices";
            Languages = new HashSet<string> { "java", "objectivec" };
            NamespacePrefix = "com";
        }
    }
}