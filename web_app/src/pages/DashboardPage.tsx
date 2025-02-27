import { Button } from "../components/ui/button";
import { Input } from "../components/ui/input";
import { Label } from "../components/ui/label";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "../components/ui/tabs";

export default function DashboardPage() {
  const handleFileUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (files) {
      console.log("PDFs uploaded:", files);
      // Add logic to handle PDF upload (e.g., send to backend)
    }
  };

  const handleNewsSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // Add logic to save news template
  };

  return (
    <div className="min-h-screen p-8">
      <h1 className="text-3xl font-bold mb-6">Dashboard</h1>
      <Tabs defaultValue="upload" className="w-full">
        <TabsList>
          <TabsTrigger value="upload">Upload PDFs</TabsTrigger>
          <TabsTrigger value="news">Add News Template</TabsTrigger>
        </TabsList>
        <TabsContent value="upload">
          <div className="mt-4">
            <Label htmlFor="pdf-upload">Upload PDF Files</Label>
            <Input id="pdf-upload" type="file" accept=".pdf" multiple onChange={handleFileUpload} />
          </div>
        </TabsContent>
        <TabsContent value="news">
          <form onSubmit={handleNewsSubmit} className="mt-4 space-y-4">
            <div>
              <Label htmlFor="title">News Title</Label>
              <Input id="title" placeholder="Enter news title" />
            </div>
            <div>
              <Label htmlFor="content">Content</Label>
              <Input id="content" placeholder="Enter news content" />
            </div>
            <Button type="submit">Save Template</Button>
          </form>
        </TabsContent>
      </Tabs>
    </div>
  );
}